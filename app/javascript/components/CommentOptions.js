import React from "react"
import PropTypes from "prop-types"

class CommentOptions extends React.Component {
    constructor(props) {
        super(props);

        this.currentUser = this.props.currentUser || {};
        this.state = {
            dropDownStatus: '',
            comment: this.props.comment
        }
    }

    toggleDropdown = () => {
        let dropDownStatus = this.state.dropDownStatus == '' ? 'clicked' : ''
        this.setState({
            dropDownStatus: dropDownStatus
        })
    }

    isOwner() {
        return (this.currentUser && this.currentUser.id == this.state.comment.user.id)
    }

    render() {
        return (
            <span className={"dropdown pull-right " + this.state.dropDownStatus} onClick={this.toggleDropdown}>
                <i className="fa fa-ellipsis-v"></i>
                <span className="custom-dropdown-content">
                    {this.isOwner() &&
                    <span className=" text-center" onClick={this.props.editComment}>
                        <i className="sl sl-icon-pencil"></i> Edit
                    </span>
                    }
                    {this.isOwner() &&
                    <span className=" text-center" onClick={() => { if (window.confirm('Are you sure you wish to delete this item?')) this.props.deleteComment(this.state.comment) } } >
                        <i className="fa fa-times"></i> Delete
                        </span>
                    }
                </span>
            </span>
        );
    }
}

CommentOptions.propTypes = {
    comment: PropTypes.object
};
export default CommentOptions
