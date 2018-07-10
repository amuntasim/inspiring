import React, { Component } from 'react';
import ContentEditable from 'react-contenteditable'
import qwest from 'qwest';

class StoryForm extends Component {
    constructor(props) {
        super(props);
        this.currentUser = this.props.currentUser || {}

        let story = this.props.story || {
                id: null,
                description: ''
            }
        this.editing = story.id ? true : false;
        let expanded = ''
        let storyButtonsClass = 'hidden'
        if (this.editing) {
            expanded = 'expanded';
            storyButtonsClass = '';
        }

        this.state = {
            storyButtonsClass: storyButtonsClass,
            expanded: expanded,
            selectedBookCoverFiles: [],
            submitFormProgress: 0,
            isSubmittingForm: false,
            story: story
        };
    }

    componentWillMount() {
        if (this.editing) {
            let url = REACT_CLIENT.api.base_url + '/stories/' + this.state.story.id;
            qwest.get(url).then((xhr,response) => {
                this.setState({
                    selectedBookCoverFiles: response.story.photos,
                    story: {
                        id: response.story.id,
                        description: response.story.description,
                        errors: {}
                    }
                });
            });
        }
    }
    expandStoryForm = (e) => {
        this.setState({expanded: 'expanded', storyButtonsClass: ''})
    }

    closeStoryForm = (e) => {
        this.setState({
            expanded: '',
            storyButtonsClass: 'hidden'
        })
        if (this.props.closeEditModal) {
            this.props.closeEditModal();
        }
    }

    handleDescriptionChange = (event) => {
        let { story } = this.state;
        story.description = event.target.value;
        this.setState({story: story});
    }

    submitButtonText() {
        let text = this.editing ?
            this.state.isSubmittingForm ? 'Updating...' : 'Update' :
            this.state.isSubmittingForm ? 'Saving...' : 'Save'
        return text;
    }

    render() {
        return (
            <div className={"user-input-section story-form " + this.state.expanded}>
                <img className="avatar size32"
                     src={this.currentUser.avatar_url}/>

                <div className={"story-form-header " + this.state.storyButtonsClass}>
                    Post
                    <button title="Close" type="button" onClick={this.closeStoryForm}
                            className="btn btn-xs close-editable-btn ">Close
                    </button>
                </div>

                <ContentEditable
                    className="story-editable " placeholder="What's your story?"
                    html={this.state.story.description}
                    onFocus={this.expandStoryForm}
                    onChange={e => this.handleDescriptionChange(e)}
                    />

                <div className={"row margin-top-10 " + this.state.storyButtonsClass}>
                    <div className="col-md-12">
                        <div className="pull-left">
                            <div className="photoUpload">
                                <div className="form-group">
                                    <label>Uploads</label>
                                    {this.renderUploadCoversButton()}
                                    {this.renderSelectedBookCoverFiles()}
                                </div>
                                {this.renderUploadFormProgress()}
                            </div>
                        </div>
                        <div className="pull-right">
                            <button
                                disabled={this.state.isSubmittingForm}
                                onClick={e => this.handleFormSubmit()}
                                className="btn btn-primary">
                                {this.submitButtonText()}
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        );
    }

    getNumberOfSelectedFiles = () => {
        return this.state.selectedBookCoverFiles.filter(el => {
            return el._destroy !== true;
        }).length;
    }

    storyCoversId (){
        return "story_covers" + this.state.story.id;
    }

    renderUploadCoversButton = () => {
        let numberOfSelectedCovers = this.getNumberOfSelectedFiles();
        return (
            <div>
                <input
                    name="covers[]"
                    ref={field => (this.storyCoversField = field)}
                    type="file"
                    multiple="true"
                    disabled={this.state.isSubmittingForm}
                    accept="image/*"
                    style={{
            width: 0.1,
            height: 0.1,
            opacity: 0,
            overflow: 'hidden',
            position: 'absolute',
            zIndex: -1
          }}
                    id={this.storyCoversId()}
                    onChange={e => this.handleBookCoversChange(e)}
                    className="form-control"
                    />
                <label
                    disabled={this.state.isSubmittingForm}
                    className="btn btn-success"
                    htmlFor={this.storyCoversId()}>
                    <span className="fa fa-cloud-upload"/>
                    &nbsp; &nbsp;
                    {numberOfSelectedCovers === 0
                        ? 'Upload Files'
                        : `${numberOfSelectedCovers} file${numberOfSelectedCovers !== 1
                        ? 's'
                        : ''} selected`}
                </label>
            </div>
        );
    }

    renderSelectedBookCoverFiles = () => {
        let fileDOMs = this.state.selectedBookCoverFiles.map((el, index) => {
            if (el._destroy) {
                return null;
            }

            return (
                <li key={index}>
                    <div className="photo">
                        <img
                            width={150}
                            src={el.id ? el.url : URL.createObjectURL(el)}
                            style={{ alignSelf: 'center' }}
                            />

                        <div
                            className="remove"
                            onClick={() => this.removeSelectedBookCoverFile(el, index)}>
                            <span style={{ top: 2 }} className="fa fa-remove"/>
                        </div>
                    </div>
                    <div className="file-name">
                        {el.name}
                    </div>
                </li>
            );
        });

        return (
            <ul className="selected-covers">
                {fileDOMs}
            </ul>
        );
    }

    renderUploadFormProgress = () => {
        if (this.state.isSubmittingForm === false) {
            return null;
        }

        return (
            <div className="progress">
                <div
                    className={
            'progress-bar progress-bar-info progress-bar-striped' +
            (this.state.submitFormProgress < 100 ? 'active' : '')
          }
                    role="progressbar"
                    aria-valuenow={this.state.submitFormProgress}
                    area-valuemin="0"
                    area-valuemax="100"
                    style={{ width: this.state.submitFormProgress + '%' }}>
                    {this.state.submitFormProgress}% Complete
                </div>
            </div>
        );
    }

    removeSelectedBookCoverFile = (cover, index) => {
        let { selectedBookCoverFiles } = this.state;
        if (cover.id) {
            selectedBookCoverFiles[index]._destroy = true;
        } else {
            selectedBookCoverFiles.splice(index, 1);
        }

        this.setState({
            selectedBookCoverFiles: selectedBookCoverFiles
        });
    }

    handleBookCoversChange = () => {
        let selectedFiles = this.storyCoversField.files;
        let { selectedBookCoverFiles } = this.state;
        for (let i = 0; i < selectedFiles.length; i++) {
            selectedBookCoverFiles.push(selectedFiles.item(i));
        } //end for

        this.setState(
            {
                selectedBookCoverFiles: selectedBookCoverFiles
            },
            () => {
                this.storyCoversField.value = null;
            }
        );
    }

    buildFormData = () => {
        let formData = new FormData();
        formData.append('story[description]', this.state.story.description);

        let { selectedBookCoverFiles } = this.state;
        for (let i = 0; i < selectedBookCoverFiles.length; i++) {
            let file = selectedBookCoverFiles[i];
            if (file.id) {
                if (file._destroy) {
                    formData.append(`story[photos_attachments_attributes][${i}][id]`, file.id);
                    formData.append(`story[photos_attachments_attributes][${i}][_destroy]`, '1');
                }
            } else {
                formData.append(
                    `story[photos][]`,
                    file,
                    file.name
                );
            }
        }
        return formData;
    }


    submitForm = () => {
        var self = this;
        var url = REACT_CLIENT.api.base_url + '/stories/' + (self.editing ? this.state.story.id : '');
        qwest.map(self.editing ? 'PATCH' : 'POST', url, this.buildFormData(), null, function (xhr) {
            xhr.upload.onprogress = function (progressEvent) {
                let percentage = progressEvent.loaded * 100.0 / progressEvent.total;
                self.setState({
                    submitFormProgress: percentage
                });
            };
        }).then(function (xhr, resp) {
            if (resp) {
                if (resp.story) {
                    self.editing ?
                    self.props.onStoryUpdated(resp.story) :
                    self.props.onStoryAdded(resp.story)
                }
                self.setState({
                    isSubmittingForm: false,
                    story: {description: ''}
                });
                self.closeStoryForm()
            }
        }).catch(function (e, xhr, response) {
            let { story } = self.state;
            story.errors = error.response.data;
            this.setState({
                isSubmittingForm: false,
                submitFormProgress: 0,
                story: story
            });
        });

    }

    handleFormSubmit = () => {
        let { story } = this.state;
        story.errors = {};
        this.setState(
            {
                isSubmittingForm: true,
                story: story
            },
            () => {
                this.submitForm();
            }
        );
    }
}

export default StoryForm;
